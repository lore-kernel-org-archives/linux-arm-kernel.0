From: gregkh@linuxfoundation.org (Greg KH)
Date: Mon, 12 Aug 2013 13:20:40 -0700
Subject: [PATCH V5 4/6] USB: OHCI: make ohci-spear a separate driver
In-Reply-To: <CAKohponadFf3qNM+9h+qRMrcnhn0ByvXG-JTTofV0rr-2W8mug@mail.gmail.com>
References: <1370585013-12809-1-git-send-email-manjunath.goudar@linaro.org>
 <1376290020-26253-1-git-send-email-manjunath.goudar@linaro.org>
 <1376290020-26253-5-git-send-email-manjunath.goudar@linaro.org>
 <CAKohponadFf3qNM+9h+qRMrcnhn0ByvXG-JTTofV0rr-2W8mug@mail.gmail.com>
Message-ID: <20130812202040.GA26359@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 12, 2013 at 12:26:09PM +0530, Viresh Kumar wrote:
> On 12 August 2013 12:16, Manjunath Goudar <manjunath.goudar@linaro.org> wrote:
> > This work is part of enabling multi-platform kernels on ARM;
> > it would be nice to have in 3.11.
> 
> You really want it in 3.11, we are already at 3.11-rc5 :)
> 
> Whatever you write here gets in git history with your patch and I
> am sure you never wanted this to be commited. :)
> 
> So, both the above lines must be removed from each of
> your patches and must be present only once in the cover-letter.
> 
> Don't resend your patches now with this.. Unless Greg wants you
> to.

Yes, they all need to be resent as they don't seem to apply :(

Please just delete that part of the sentance from all of the patches in
this series.  It does not matter which tree it would be "nice" to have
them in, once they are accepted the changelog will show where it was
accepted.

thanks,

greg k-h
