From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sun, 26 Feb 2012 12:20:12 +0200
Subject: [PATCH v2 2/2] iommu/omap: fix NULL pointer dereference
In-Reply-To: <20120224131638.GH2454@amd.com>
References: <1329902086-13868-1-git-send-email-ohad@wizery.com>
 <20120223161109.GB2454@amd.com>
 <CAK=WgbYufgQY-O_MBcXc3aE23sx+r5ZQLS4h_bLUh6DKpLVqAg@mail.gmail.com>
 <20120224131638.GH2454@amd.com>
Message-ID: <CAK=WgbYg80AJCfHq==ShNkkfuxz6mfmc71hD9Z=JF_8CE9Xjcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2012 at 3:16 PM, Joerg Roedel <Joerg.Roedel@amd.com> wrote:
> Applied both and added stable-tag to the second patch. I'll send the
> pull-request when you guys also send me the correct fix for the
> outstanding initialization order issue on OMAP.

It's out, thanks!
