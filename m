From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 6 Apr 2012 10:39:40 -0300
Subject: question about i.mx21ads support
In-Reply-To: <CAEqTKjUVrm894Bw62hLNRjfEr2eNVY9aTa1bUM-R3wr1KTRXBg@mail.gmail.com>
References: <CAEqTKjUyiA_fCfboifSXXj-h_B6rGQpAM9nGnen=0mKi-w=J9w@mail.gmail.com>
 <CAOMZO5BWiQoRL3HJy7wgWUjA=FtnJJ9vqt5oau-0n6_SJT_AFQ@mail.gmail.com>
 <CAEqTKjUVrm894Bw62hLNRjfEr2eNVY9aTa1bUM-R3wr1KTRXBg@mail.gmail.com>
Message-ID: <CAOMZO5DJTtLk1o8gPJULFbf6fB+OVzQy-=RMb1RtfW0N_QdhkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 6, 2012 at 4:55 AM, George McBay <gfm@funxed.com> wrote:

> Unfortunately these changes applied to 3.3 series kernels don't help
> with the no-output kernel hang I am seeing with those versions on my
> imx21ads board, but this gives me a solid starting point for trying to
> find the change that is making the 3.3 kernels hang on this hardware.

Try passing 'earlyprintk' in the kernel command line and select
CONFIG_EARLY_PRINTK in the .config to see where it is hanging.
