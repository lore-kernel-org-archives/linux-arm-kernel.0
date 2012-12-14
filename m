From: horms@verge.net.au (Simon Horman)
Date: Fri, 14 Dec 2012 22:47:28 +0900
Subject: [PATCH 1/2] ARM: shmobile: sh73a0: Add CPU sleep suspend
In-Reply-To: <CANqRtoQMweOU-Azfwu3-HXKx0Hr0seQYy1hi+arLHN-q=BSh+w@mail.gmail.com>
References: <1354709587-25288-1-git-send-email-hechtb+renesas@gmail.com>
 <CANqRtoQMweOU-Azfwu3-HXKx0Hr0seQYy1hi+arLHN-q=BSh+w@mail.gmail.com>
Message-ID: <20121214134727.GL16382@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 14, 2012 at 12:23:06PM +0900, Magnus Damm wrote:
> On Wed, Dec 5, 2012 at 9:13 PM, Bastian Hecht <hechtb@gmail.com> wrote:
> > From: Bastian Hecht <hechtb@gmail.com>
> >
> > Add the lighest possible sleep mode on Cortex-A9 cores: CPU sleep. It is
> > entered by a simple dsb and wfi instruction via cpu_do_idle(). As just
> > clocks are stopped there is no need to save or restore any state of the
> > system.
> >
> > Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> 
> Acked-by: Magnus Damm <damm@opensource.se>

Hi Bastian,

could you please re-spin this series on top of the soc5 or next
branches of my renesas tree on kernel.org?

Feel free to include Magnus's Ack unless you make any
non-trivial changes.

Thanks
