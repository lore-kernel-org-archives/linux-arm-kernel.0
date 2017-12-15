From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 15 Dec 2017 15:28:34 +0100
Subject: [PATCH 0/2] Use SPDX-License-Identifier for rockchip devicetree
 files
In-Reply-To: <CAOFm3uHba4kBD81thpxSpDBsDS4Y5m7cN2jfYt_uT5atdSDmqg@mail.gmail.com>
References: <20171215114427.32059-1-klaus.goger@theobroma-systems.com>
 <CAOFm3uHba4kBD81thpxSpDBsDS4Y5m7cN2jfYt_uT5atdSDmqg@mail.gmail.com>
Message-ID: <21020918.S4038j3A1a@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 15. Dezember 2017, 14:45:34 CET schrieb Philippe Ombredanne:
> Klaus,
> 
> On Fri, Dec 15, 2017 at 12:44 PM, Klaus Goger
> 
> <klaus.goger@theobroma-systems.com> wrote:
> > This patch series replaces all the license text in rockchip devicetree
> > files text with a proper SPDX-License-Identifier.
> > It follows the guidelines submitted[1] by Thomas Gleixner that are not
> > yet merged.
> > 
> > These series also fixes the issue with contradicting statements in most
> > licenses. The introduction text claims to be GPL or X11[2] but the
> > following verbatim copy of the license is actually a MIT[3] license.
> > The X11 license includes a advertise clause and trademark information
> > related to the X Consortium. As these X Consortium specfic points are
> > irrelevant for us we stick with the actuall license text.
> > 
> > [1] https://patchwork.kernel.org/patch/10091607/
> > [2] https://spdx.org/licenses/X11.html
> > [3] https://spdx.org/licenses/MIT.html
> 
> FWIW, the X11 license name was not always something clearly defined.
> SPDX calls it clearly MIT which is the most widely accepted name for
> the corresponding text. And this is also what we have in Thomas doc
> patches that should be the kernel reference.
> 
> Also, as a general note, you want to make sure that such as patch set
> is not merged by mistake until you have collected an explicit review
> or ack from all the copyright holders involved.

Just for my understanding, is it really necessary to get Acks from _all_
previous contributors?

I see that Thomas patches moving license texts into the kernel itself do not 
seem to have landed yet, but when the actual license text does _not_ change
and only its location to a common place inside the kernel sources, it feels
a bit overkill trying to get Acks from _everybody_ that contributed to
Rockchip devicetrees for the last 4 years.

If we would actually want to change the license I would definitly feel 
differently, but the license text does not change.


Thanks
Heiko
