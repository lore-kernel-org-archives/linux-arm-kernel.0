From: yitian.bu@tangramtek.com (yitian)
Date: Fri, 2 Oct 2015 15:22:33 +0800
Subject: [alsa-devel] [RESEND PATCH 1/1] ASoC: dwc: correct irq
 clear	method
In-Reply-To: <20151001100330.GA12635@sirena.org.uk>
References: <006301d0fac4$94eb5890$bec209b0$@tangramtek.com>
 <20150930181751.GT15635@sirena.org.uk>
 <00fe01d0fbf2$5a73cba0$0f5b62e0$@tangramtek.com>
 <20151001100330.GA12635@sirena.org.uk>
Message-ID: <001001d0fce3$215bbb60$64133220$@tangramtek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark:
> From: alsa-devel-bounces at alsa-project.org
> [mailto:alsa-devel-bounces at alsa-project.org] On Behalf Of Mark Brown
> Sent: Thursday, October 1, 2015 6:04 PM
> To: yitian <yitian.bu@tangramtek.com>
> Cc: alsa-devel at alsa-project.org; wsa at the-dreams.de;
> linux-kernel at vger.kernel.org; Andrew.Jackson at arm.com;
> lgirdwood at gmail.com; tiwai at suse.com;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [alsa-devel] [RESEND PATCH 1/1] ASoC: dwc: correct irq clear
> method
> 
> On Thu, Oct 01, 2015 at 10:39:09AM +0800, yitian wrote:
> 
> > > This doesn't apply against current code, please check and resend.
> 
> > I synced up to latest kernel branch, the code is the same as what this
> patch
> > was
> > generated.
> 
> The "latest kernel branch" was neither v4.3-rc1 nor my for-next
> branch, at least as far as git am was concerned, so I couldn't apply the
> patch.

I am sorry.
I used Linux v4.3-rc3 to generate the patch, and I assumed that was the same
as v4.3-rc1.
I generated new patch based on next-20151001, please review it again,
thanks.
