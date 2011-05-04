From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 04 May 2011 09:35:10 -0400 (EDT)
Subject: [PATCH 1/2] Moving Marvell Dove platform defaults to ARMv7
In-Reply-To: <BANLkTins+RioLLufdu2Wnt=Heyp12z5NXw@mail.gmail.com>
References: <1302173382-25577-1-git-send-email-kostap@marvell.com>
	<BANLkTikCBDCYr6BHz4zWPvHfuAQ+eCtvNg@mail.gmail.com>
	<alpine.LFD.2.00.1105021354410.24613@xanadu.home>
	<alpine.LFD.2.00.1105021434230.24613@xanadu.home>
	<BANLkTimdti4Cj2BMqsRdnmOB7Dtt9=QTCQ@mail.gmail.com>
	<BANLkTimXLfcAsU47R+xEvU8Nq-A8NEWmOw@mail.gmail.com>
	<alpine.LFD.2.00.1105031542480.24613@xanadu.home>
	<BANLkTins+RioLLufdu2Wnt=Heyp12z5NXw@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1105040934350.24613@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 4 May 2011, saeed bishara wrote:

> >>
> >> I'm OK on this change. MMP2 (PJ4 core) is also used as ARMv7 capable.
> >
> > So I did remove those entries. ?That also allows for the Dove kernel to
> > be compiled using Thumb2 without any additional changes.
> have you also loaded that kernel?

Yes, of course.  And it works just fine.


Nicolas
