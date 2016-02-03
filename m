From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 3 Feb 2016 12:23:16 -0200
Subject: SGTL5000 misc
In-Reply-To: <CAEuupiuhPR48Upo=8f0zV8cxf0Vefgx3qA+vC+QDWAOV4n-e3Q@mail.gmail.com>
References: <CAEuupiuhPR48Upo=8f0zV8cxf0Vefgx3qA+vC+QDWAOV4n-e3Q@mail.gmail.com>
Message-ID: <CAOMZO5BPNc1ncz6J8yhcBYywCVuTxKYMYhiNUt_Jq3LZsKdi+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 3, 2016 at 11:42 AM, Erik Friesen <friesendrywall@gmail.com> wrote:
> First post on the list here..
>
> I have been working with an embeddedarm ts4900 and built a baseboard
> that uses the sgtl5000.  I also have worked with the RiotBoard, which
> uses the same chip, both using the i.mx6 arm.  I find that
> occasionally the sgtl5000 is resetting, and there is no way to bring
> it back online.  As near as I can tell, the i2c bus comes back alive,
> for example alsamixer communicates fine, coms happen on the i2c bus
> per scope.  However, its obvious the chip never got re initialized by
> how it acts.
>
> I know the thing shouldn't reset, that is the primary problem, but I
> still want some backup method.  Its probably due to ground bounce from
> a non earth grounded setup.  It could be that using the external
> regulator will help, we will see.
>
> Is there a suggestion on a way the sgtl5000.c could be extended to
> support some sort of re init routine?
>
> I am using the embeddedarm repo as a base.

Which kernel version do you use?
