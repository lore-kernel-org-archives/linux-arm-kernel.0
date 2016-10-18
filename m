From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 18 Oct 2016 15:38:19 +0800
Subject: [PATCH v2 7/9] ARM: sunxi: Remove useless allwinner,
 drive property
In-Reply-To: <076406072c137a50df41c4acb0c582a688792976.1476200742.git-series.maxime.ripard@free-electrons.com>
References: <cover.7edc6c25be8a5e2efdda6a82e102dbf7ece6aa64.1476200742.git-series.maxime.ripard@free-electrons.com>
 <076406072c137a50df41c4acb0c582a688792976.1476200742.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v66_h+DW05UgOdJZ3rtQ+3ka_f8-AmFCeam4BQpZ5LwCsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2016 at 11:46 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The allwinner,drive property set to 10mA was really considered as our
> default. Remove all those properties entirely to make that obvious.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
