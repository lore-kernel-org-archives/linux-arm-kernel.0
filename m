From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 03 Dec 2013 10:33:43 +0100
Subject: [PATCH] pinctrl: samsung: Allow pin value to be initialized using
 pinfunc.
In-Reply-To: <CACRpkdYDONQ-7U3hGYnx7jb0_Y=rcOcvy-2F1dO058FfOO4stg@mail.gmail.com>
References: <1384881351-10782-1-git-send-email-t.figa@samsung.com>
 <2715269.S45Tc0DQGQ@flatron>
 <CACRpkdYDONQ-7U3hGYnx7jb0_Y=rcOcvy-2F1dO058FfOO4stg@mail.gmail.com>
Message-ID: <2004634.MefHDYV4b2@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 of December 2013 10:31:12 Linus Walleij wrote:
> On Tue, Nov 26, 2013 at 1:30 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> 
> > IMHO a way to specify a default safe state of all pins (with lowest power
> > consumption, without possibility of glitching external devices, etc.)
> > would be really useful for Samsung platforms (and probably Renesas ones
> > as Kevin wrote).
> 
> I'm following :-)
> 
> Now if we could see some more details and a patch, that would
> be great ...

Yeah, I would like to see them too. ;)

Unfortunately my make_pinctrl_default_state_patches() function is
returning -ENOTIME at the moment. :( (I hope to get it fixed
later this month, though.)

Best regards,
Tomasz
