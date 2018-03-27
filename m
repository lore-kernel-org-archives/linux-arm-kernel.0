From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 27 Mar 2018 23:06:33 +0200 (CEST)
Subject: [PATCH 1/1] mtd: ubi: Update ubi-media.h to dual license
In-Reply-To: <CAFLxGvxcWLxHyTzgbGssqOEUp2=TU07mLk1-XHavL4HU8N7caQ@mail.gmail.com>
References: <20180212105642.8662-1-lionel.debieve@st.com>
 <20180212105642.8662-2-lionel.debieve@st.com>
 <CAFLxGvxcWLxHyTzgbGssqOEUp2=TU07mLk1-XHavL4HU8N7caQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1803272305350.1618@nanos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 27 Mar 2018, Richard Weinberger wrote:

> On Mon, Feb 12, 2018 at 11:56 AM, Lionel Debieve <lionel.debieve@st.com> wrote:
> > Update license template using SPDX. Move the global layout
> > of UBI headers to dual license helping UBI to be the standard
> > solution for raw NAND management.
> 
> So the goal is re-implementing UBI under a non-GPL license?
> 
> If we get a clear ack from all major UBI copyright holders, fine by me.

I already acked that for the u-boot SPL code. So yes:

Acked-by: Thomas Gleixner <tglx@linutronix.de>
