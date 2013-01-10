From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 10 Jan 2013 16:27:34 +0100
Subject: [PATCHv2] ARM: mxs: select USB_ARCH_HAS_EHCI
In-Reply-To: <20130110151659.GB9139@S2101-09.ap.freescale.net>
References: <1357830235-15661-1-git-send-email-maxime.ripard@free-electrons.com>
 <20130110151659.GB9139@S2101-09.ap.freescale.net>
Message-ID: <50EEDDE6.3030906@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On 10/01/2013 16:17, Shawn Guo wrote:
> On Thu, Jan 10, 2013 at 04:03:55PM +0100, Maxime Ripard wrote:
>> Commit 09f6ffde introduced a dependency on USB_EHCI_HCD for the chipidea
>> USB host driver, that in turns depends on USB_ARCH_HAS_EHCI.
>>
>> If this symbol is not selected by the ARCH, we are not able to use the
>> chipidea driver anymore.
>>
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> ---
>>  drivers/usb/Kconfig |    1 +
>>  1 file changed, 1 insertion(+)
> 
> Now, it should go via usb rather than arm-soc tree.

Yes, that's what I thought just after sending the patch.

Sorry for that
Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
