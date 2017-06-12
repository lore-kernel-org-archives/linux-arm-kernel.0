From: aisheng.dong@nxp.com (A.S. Dong)
Date: Mon, 12 Jun 2017 14:23:10 +0000
Subject: [PATCH 6/6] tty: serial: lpuart: add a more accurate baud rate
 calculation method
In-Reply-To: <CAHp75VdgLoavZrf+T1-cyPj2A30mGeyDEgye3qZoWXJE6inE_Q@mail.gmail.com>
References: <1494316248-24052-1-git-send-email-aisheng.dong@nxp.com>
 <1494316248-24052-7-git-send-email-aisheng.dong@nxp.com>
 <CAHp75Vemc5qoD7gbc_sJBSasYTFYSYOuWZv4N-4X60arWX8aJg@mail.gmail.com>
 <AM3PR04MB3062F7BCE82860C377C214E80F10@AM3PR04MB306.eurprd04.prod.outlook.com>
 <CAHp75VcH0j3ddaZ3iStNO4QcAwJKZ7BAMwUTthum2no1ucs2ww@mail.gmail.com>
 <AM3PR04MB306214514B820D66535E28B80CE0@AM3PR04MB306.eurprd04.prod.outlook.com>
 <CAHp75VcSToSfbUZ2TP0OsLRjV4TNpq7D_=4tnB_+rDvS2jp22Q@mail.gmail.com>
 <AM3PR04MB30678CBD87777C6816DEFA580CE0@AM3PR04MB306.eurprd04.prod.outlook.com>
 <CAHp75VdgLoavZrf+T1-cyPj2A30mGeyDEgye3qZoWXJE6inE_Q@mail.gmail.com>
Message-ID: <AM3PR04MB30630CDA4E0FD2B5079072E80CD0@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Andy Shevchenko [mailto:andy.shevchenko at gmail.com]
> Sent: Friday, June 09, 2017 11:49 PM
> To: A.S. Dong
> Cc: linux-serial at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm
> Mailing List; Greg Kroah-Hartman; Jiri Slaby; Andy Duan; Stefan Agner;
> Mingkai Hu; Y.B. Lu; Dong Aisheng
> Subject: Re: [PATCH 6/6] tty: serial: lpuart: add a more accurate baud
> rate calculation method
> 
> On Fri, Jun 9, 2017 at 5:20 PM, A.S. Dong <aisheng.dong@nxp.com> wrote:
> >> > How about you send a separate baud algorithm improvement patch later?
> >>
> >> Why not to do it right a way?
> >>
> >
> > Because I thought that could be a separate patch which is doing
> > algorithm improvement, then we can have the full history and a clear
> comparison.
> >
> > And also we are still not sure whether it works, we don't want to
> > block on it too long.
> >
> > But if you're pretty sure about it, I would wait for some more time.
> >
> > However, personally I would still rather keep them in two separate
> > Patches for clearer history and comparison.
> 
> Since we already near to -rc5, I would rather agree with you.
> So, please proceed with your approach and we can modify it in relaxing
> mode later on.
> 
> Thanks, and sorry for the delay!

Never mind.
A professional review is always respectable and appreciated.

Thanks

Regards
Dong Aisheng
