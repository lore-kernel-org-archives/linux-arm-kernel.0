From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Fri, 11 Apr 2014 10:12:59 +0200
Subject: [PATCH RESEND 4/5] Documentation: add the Marvell Berlin pinctrl
 documentation
In-Reply-To: <20140411143318.67e55a17@xhacker>
References: <1397135274-10764-1-git-send-email-antoine.tenart@free-electrons.com>
 <1397135274-10764-5-git-send-email-antoine.tenart@free-electrons.com>
 <20140411143318.67e55a17@xhacker>
Message-ID: <20140411081259.GA20147@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jisheng,

On Fri, Apr 11, 2014 at 02:33:18PM +0800, Jisheng Zhang wrote:
> On Thu, 10 Apr 2014 06:07:53 -0700
> Antoine T?nart <antoine.tenart@free-electrons.com> wrote:
> > +Required subnode-properties:
> > +- berlin,group: a string describing the group's name.
> > +- berlin,function: the function used to mux the group.
> 
> Would it be better to s/function/mode? Because in mrvl internal technology
> discussion and docs, we usually say "set pinmux Gy as mode z".

The pinctrl framework uses 'function', so I guess it's better not to introduce
an other keyword that may confuse people. But I agree this is not what's used in
the Marvell's docs. What do you think about we mention it in this documentation ?

Thanks for the feedback !

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
