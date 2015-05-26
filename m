From: balbi@ti.com (Felipe Balbi)
Date: Tue, 26 May 2015 09:51:18 -0500
Subject: MUSB dual-role on AM335x behaving weirdly
In-Reply-To: <CADYTM3baVqoEBdWoQb5JFyGR2_GKm1FHMYWST1YkZV=m=ZdycQ@mail.gmail.com>
References: <20150514174907.GQ24269@saruman.tx.rr.com>
 <20150514190429.GT24269@saruman.tx.rr.com>
 <CADYTM3Zso8bV_8yFyx1-ATbL5AgkKBjvWWR4AsoZUNuLvFe1bQ@mail.gmail.com>
 <20150514192125.GU24269@saruman.tx.rr.com>
 <CADYTM3bbEAVefFZtivJf5Z+2Q+1zDZEvNhqE5ytsOxDX7hjbdA@mail.gmail.com>
 <20150514192946.GV24269@saruman.tx.rr.com>
 <CADYTM3Zk2iD8YMj75CoLJn=4kpoXoXEKUWj2QzdXKGCJjtfG2A@mail.gmail.com>
 <CADYTM3a1QWnec1D=wT=fgZ-RCXAx_qZYYoFg5gWOy0yT4vovHA@mail.gmail.com>
 <20150514212653.GC3338@piout.net>
 <CADYTM3baVqoEBdWoQb5JFyGR2_GKm1FHMYWST1YkZV=m=ZdycQ@mail.gmail.com>
Message-ID: <20150526145118.GD26599@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 14, 2015 at 04:36:33PM -0500, Bin Liu wrote:
> Alexandre,
> 
> On Thu, May 14, 2015 at 4:26 PM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
> > On 14/05/2015 at 16:16:12 -0500, Bin Liu wrote :
> >> I think I found the root cause of the problem: board design issue - I
> >> bet the custom board has too much cap on VBUS line. It should be <
> >> 10uF.
> >>
> >
> > We have a custom board that exhibits the issue but it only has a 100nF
> > cap on VBUS.
> 
> Have you measured the VBUS discharging? Is there any way to share your
> schematics?

Alexandre, any further comments ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150526/3e70a928/attachment.sig>
