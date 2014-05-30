From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 30 May 2014 10:28:51 -0600
Subject: [RFC PATCH 04/11] coresight: add CoreSight ETB driver
In-Reply-To: <20140530135321.GQ3693@n2100.arm.linux.org.uk>
References: <1401457391-12242-1-git-send-email-mathieu.poirier@linaro.org>
 <1401457391-12242-5-git-send-email-mathieu.poirier@linaro.org>
 <20140530135321.GQ3693@n2100.arm.linux.org.uk>
Message-ID: <CANLsYkyEBfyVhb3d1heFq1+QosSmHWDAd0V0Cq2QiKLdk9-a6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 May 2014 07:53, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> NAK for all the reasons I mentioned in the previous submission in 2012.
>
> You partially did the right thing - you read through the previous
> submission, and you said in your cover message that you had addressed
> some of the comments from that submission.
>
> What I find extremely distasteful is that you seem to have chosen to
> completely ignore my comments - you haven't mentioned them in your
> covering message at all, and you've just gone ahead and converted ETM
> and ETB to be platform devices.
>
> That gets you a NAK for that change, because you have done nothing what
> so ever to address the concerns I raised.

>From my initial reading of your assessment it wasn't clear to me that
your opinion leaned toward registering with the AMBA bus.  Now that
this point has been clarified I will go back to the AMBA interface for
my next submission.

Is there anything else not AMBA releated that you'd like to see modified?

Thanks,
Mathieu

>
> Since you seem to have ignored my comments, this is as far as I'm looking
> at your submission, and you can consider the entire submission NAK'd by
> me.
>
> Thanks.
>
> --
> FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
> improving, and getting towards what was expected from it.
