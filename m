From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Fri, 10 Jan 2014 19:46:57 +0900
Subject: [PATCH] arm64: dts:  add <dt-bindings/> symlink
In-Reply-To: <20140110102226.63f5bf30@ipc1.ka-ro>
References: <1389346197-5127-1-git-send-email-pankaj.dubey@samsung.com>
 <20140110102226.63f5bf30@ipc1.ka-ro>
Message-ID: <52CFCFA1.4080405@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/2014 06:22 PM, Lothar Wa?mann wrote:
> Hi,
>
> Pankaj Dubey wrote:
>> Add symlink to include/dt-bindings from arch/arm64/boot/dts/include/ to
>> match the ones in ARM architectures so that preprocessed device
>> tree files can include various useful constant definitions.
>>
>> See commit c58299a (kbuild: create an "include chroot" for DT bindings)
>> merged in v3.10-rc1 for details.
>>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>>   arch/arm64/boot/dts/include/dt-bindings |    1 +
>>   1 file changed, 1 insertion(+)
>>   create mode 120000 arch/arm64/boot/dts/include/dt-bindings
>>
>> diff --git a/arch/arm64/boot/dts/include/dt-bindings b/arch/arm64/boot/dts/include/dt-bindings
>> new file mode 120000
>> index 0000000..08c00e4
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/include/dt-bindings
>> @@ -0,0 +1 @@
>> +../../../../../include/dt-bindings
>> \ No newline at end of file
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
I just created symlink file to "include/dt-bindings", and when created 
patch it is showing this line
at the end of patch. I do not have much idea why this came in patch? But 
when I checked similar patches
it looks like it is required.
> Lothar Wa?mann
