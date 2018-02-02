From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 2 Feb 2018 11:27:53 -0800
Subject: [PATCH] arm64: dts: angler: add pstore-ramoops support
In-Reply-To: <20180112023354.GA16005@mini-rhel.redhat.com>
References: <1514446709-19347-1-git-send-email-zhuoweizhang@yahoo.com>
 <20180112023354.GA16005@mini-rhel.redhat.com>
Message-ID: <20180202192753.GH12728@builder>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 11 Jan 18:33 PST 2018, Jeremy McNicoll wrote:

> On Thu, Dec 28, 2017 at 02:38:29AM -0500, zhuoweizhang at yahoo.com wrote:
> > From: Zhuowei Zhang <zhuoweizhang@yahoo.com>
> > 
> > Support pstore-ramoops for retrieving kernel oops and panics after reboot.
> > 
> > The address and configs are taken from the downstream kernel's device tree.
> > 
> > Signed-off-by: Zhuowei Zhang <zhuoweizhang@yahoo.com>

Hi Zhuowei,

This patch looks good, but I'm unable to find the original patch in my
inbox, at lkml.org or at patchwork.kernel.org. Can you please resend the
original patch to linux-arm-msm at vger.kernel.org, with Kees' R-b and
Jeremy's A-b.

Regards,
Bjorn
