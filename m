From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 14 Dec 2012 12:23:06 +0900
Subject: [PATCH 1/2] ARM: shmobile: sh73a0: Add CPU sleep suspend
In-Reply-To: <1354709587-25288-1-git-send-email-hechtb+renesas@gmail.com>
References: <1354709587-25288-1-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <CANqRtoQMweOU-Azfwu3-HXKx0Hr0seQYy1hi+arLHN-q=BSh+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 5, 2012 at 9:13 PM, Bastian Hecht <hechtb@gmail.com> wrote:
> From: Bastian Hecht <hechtb@gmail.com>
>
> Add the lighest possible sleep mode on Cortex-A9 cores: CPU sleep. It is
> entered by a simple dsb and wfi instruction via cpu_do_idle(). As just
> clocks are stopped there is no need to save or restore any state of the
> system.
>
> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>

Acked-by: Magnus Damm <damm@opensource.se>
