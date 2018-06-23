From: olof@lixom.net (Olof Johansson)
Date: Sat, 23 Jun 2018 10:17:16 -0700
Subject: [GIT PULL] Renesas ARM Based SoC Fixes for v4.18
In-Reply-To: <cover.1528889592.git.horms+renesas@verge.net.au>
References: <cover.1528889592.git.horms+renesas@verge.net.au>
Message-ID: <CAOesGMi5RDwv3jstPJ8ZMcKsbmYbhpq-2SyofBTt4mUWvZONJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2018 at 4:41 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
>
> Please consider these Renesas ARM based SoC fixes for v4.18.
>
> This pull request is based on renesas-soc-for-v4.18,
> which you have already pulled.
>
> The following changes since commit 086b399965a7ee7e50c3b3c57f2dba30ff0334b0:
>
>   soc: renesas: r8a77990-sysc: Add workaround for 3DG-{A,B} (2018-05-16 10:57:44 +0200)
>
> are available in the git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes-for-v4.18
>
> for you to fetch changes up to 977d5ba4507dfe5b1346597ee57750262d8d2b19:
>
>   soc: renesas: rcar-sysc: Make PM domain initialization more robust (2018-06-08 10:04:25 +0200)
>
> ----------------------------------------------------------------
> Renesas ARM Based SoC Fixes for v4.18
>
> Make PM domain initialization more robust in Renesas R-Car SYSC driver.
> This resolves a regression due to re-parenting of PM domains by
> 086b399965a7ee7e ("soc: renesas: r8a77990-sysc: Add workaround for 3DG-{A,B}").
>

Merged, thanks.


-Olof
