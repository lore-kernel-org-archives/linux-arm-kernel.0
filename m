From: marex@denx.de (Marek Vasut)
Date: Fri, 18 Dec 2015 13:45:05 +0100
Subject: [PATCH] ARM: socfpga: Repair incorrectly applied MCV patch
In-Reply-To: <alpine.DEB.2.02.1512180623300.7406@linux-builds1>
References: <1450395498-9827-1-git-send-email-marex@denx.de>
 <alpine.DEB.2.02.1512180623300.7406@linux-builds1>
Message-ID: <201512181345.05923.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, December 18, 2015 at 01:26:54 PM, Dinh Nguyen wrote:
> On Thu, 17 Dec 2015, Marek Vasut wrote:
> > For whatever reason, this patch was not applied verbatim and had all
> > tabs replaced with spaces. Replace them back by a quick sed.
> 
> Thanks for catching this. I think what happened was that I had to pull this
> patch from the mailing list, and whenever I forward a patch from my gmail
> account, I can't seem to be able to use git am.
> 
> Anyways, patch is applied.

Thanks :)

Best regards,
Marek Vasut
