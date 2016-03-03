From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Mar 2016 17:13:47 +0000
Subject: [PATCH v2 0/3] fix memremap on ARM
In-Reply-To: <CAKv+Gu_8Fggh+hnVnj6pM6PbOysWFTNt=ot6nudLur9nzs2FVg@mail.gmail.com>
References: <1456508053-15015-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu_8Fggh+hnVnj6pM6PbOysWFTNt=ot6nudLur9nzs2FVg@mail.gmail.com>
Message-ID: <20160303171347.GY19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 03, 2016 at 05:24:41PM +0100, Ard Biesheuvel wrote:
> If there are no remaining objections, may I suggest that Dan takes
> patch #1 and #2, and that I put the third patch into Russell's patch
> system? The only strict ordering requirement is that #1 is merged
> before #2 and #3 both hit mainline, and that is solved by taking #1
> and #2 in order.

How does the dependency between 1 and 3 get satisfied?  Your comment
makes no sense to me.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
