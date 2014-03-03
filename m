From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 3 Mar 2014 11:40:42 +0100
Subject: [PATCH v2 0/3] watchdog: sunxi: Change compatible patterns
In-Reply-To: <1391808566-31008-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1391808566-31008-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140303104042.GU607@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wim,

On Fri, Feb 07, 2014 at 10:29:23PM +0100, Maxime Ripard wrote:
> Hi,
> 
> This is the second version of the A10 watchdog compatible changes.
> The only difference with the v1 being that we're now droping the old
> compatibles, instead of keeping them, since the DT maintainers said it was
> fine.
> 
> Thanks,
> Maxime
> 
> Maxime Ripard (3):
>   watchdog: sunxi: Change compatibles
>   ARM: sunxi: Add the new watchog compatibles to the reboot code
>   ARM: sunxi: dt: Update the watchdog compatibles

Ping?

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140303/61770bbc/attachment.sig>
