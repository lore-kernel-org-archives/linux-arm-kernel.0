From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Mar 2016 23:39:06 +0000
Subject: Who is going to merge it [Was: Re: [PATCH v14 0/17] Add Analogix
 Core Display Port Driver]
In-Reply-To: <56F1D0AD.8030905@samsung.com>
References: <1455534485-1154-1-git-send-email-ykk@rock-chips.com>
 <1919945.Y1tg0YzXlm@diego> <56F1CAEB.3080701@samsung.com>
 <8949624.HmxDpZAlt2@diego> <56F1D0AD.8030905@samsung.com>
Message-ID: <20160322233906.GP19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2016 at 08:09:33AM +0900, Inki Dae wrote:
> In this case, someone else may send an email again like you "who is going to merge?"
> That would be why we need a maintainer.
> 
> drm panel is already managed well by Thierry Reding without such confusion. 

You don't need a maintainer for every subdirectory just because it's
a subdirectory...

Sometimes, having too many maintainers adds beaurocracy which becomes
counter-productive.  dw_hdmi seems to be adequately managed so far
without there needing to be a "DRM bridge maintainer".

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
