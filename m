From: tyler.baker@linaro.org (Tyler Baker)
Date: Fri, 22 Jan 2016 09:23:54 -0800
Subject: mainline build: 137 builds: 0 failed, 137 passed,
 296 warnings (v4.4-10454-g3e1e21c7bfcf)
In-Reply-To: <1605429.kGqaIzLx7t@wuerfel>
References: <56a1c8c2.6953c20a.25484.ffff85a9@mx.google.com>
 <1605429.kGqaIzLx7t@wuerfel>
Message-ID: <CANMBJr7W5uooa5+1tbTSfToeM6tS69E80ZB0E1gdcSnVaTaDaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 January 2016 at 05:19, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 21 January 2016 22:14:26 kernelci. org bot wrote:
>> Warnings summary:
>>
>>     224  <stdin>:1307:2: warning: #warning syscall copy_file_range not implemented [-Wcpp]
>
> I don't think anyone has sent this so far, sending a patch now.
>
>>      29  drivers/tty/serial/amba-pl011.c:190:27: warning: 'vendor_zte' defined but not used [-Wunused-variable]
>
> Patch sent a couple of days ago, got an Ack and waiting to be applied.
>
>>      12  net/bluetooth/mgmt.c:5493:8: warning: 'r192' may be used uninitialized in this function [-Wmaybe-uninitialized]
>>      12  net/bluetooth/mgmt.c:5493:8: warning: 'h192' may be used uninitialized in this function [-Wmaybe-uninitialized]
>
> This happens only in gcc-4.7 and gcc-4.8
>
>>       5  crypto/wp512.c:987:1: warning: the frame size of 1168 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>>       1  crypto/wp512.c:987:1: warning: the frame size of 1112 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>
> and this one only in gcc-4.7
>
> Any chance we can update the toolchain on kernelci.org to 4.9 or higher?
> I'm normally testing with gcc-5.2, which has a little better warnings.

I'm ok with upgrading to 4.9 or higher. Kevin any issues with this?
