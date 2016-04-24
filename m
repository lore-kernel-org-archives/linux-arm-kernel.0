From: lars.persson@axis.com (Lars Persson)
Date: Sun, 24 Apr 2016 07:23:01 +0000
Subject: [PATCH v2] ARM: dts: artpec: update clock bindings in artpec6.dtsi
In-Reply-To: <201604240131.28836.arnd@arndb.de>
References: <1457946103-13853-1-git-send-email-larper@axis.com>,
 <201604240131.28836.arnd@arndb.de>
Message-ID: <B0C201BA-39DF-4746-AFF7-80AF2E645429@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> 24 apr. 2016 kl. 01:31 skrev Arnd Bergmann <arnd@arndb.de>:
> 
>> On Monday 14 March 2016, Lars Persson wrote:
>> The clock binding for the main clock controller was changed to an
>> indexed controller style binding on request of the clk
>> maintainers. This updates the dtsi to use the new bindings.
>> 
>> Signed-off-by: Lars Persson <larper@axis.com>
>> ---
>> v2: Use numerical clock indexes to enable merge before the clock driver bindings
>> are in the tree.
>> 
>> arch/arm/boot/dts/artpec6.dtsi | 99 +++++++++---------------------------------
>> 1 file changed, 20 insertions(+), 79 deletions(-)
> 
> I found this patch while going through stuff that had not been applied yet.
> Is this still the latest version that we should apply for v4.7?
> 
>    Arnd

Yes it the latest. The clock driver will hit the tree in 4.7-rc1, not until then can we use the binding header file.

Thanks.

- Lars
