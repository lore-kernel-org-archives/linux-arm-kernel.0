From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 8 Oct 2013 14:54:26 +0900
Subject: [PATCH v2 2/3] ARM: shmobile: emev2: Add clock tree description
 in DT
In-Reply-To: <20131008143307.9270bd3307a0524d89088c2a@ops.dti.ne.jp>
References: <20131008143040.52f36df8edb7ab63224d8433@ops.dti.ne.jp>
 <20131008143307.9270bd3307a0524d89088c2a@ops.dti.ne.jp>
Message-ID: <CANqRtoT0EYcn6U_-Zin7eryiYGwb0C16AyLXtnsQ0Srt1PTG=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 8, 2013 at 2:33 PM,  <takasi-y@ops.dti.ne.jp> wrote:
> Add minimum clock tree description to .dts file.
> This provides same set of clocks as current sh-clkfwk version .c
> code does.
>
> Signed-off-by: Takashi Yoshii <takasi-y@ops.dti.ne.jp>
> ---
>  arch/arm/boot/dts/emev2.dtsi | 84 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)

Looking good, thanks Yoshii-san!

Acked-by: Magnus Damm <damm@opensource.se>
