From: maxi.jourdan@wanadoo.fr (Maxime Jourdan)
Date: Sat, 4 Aug 2018 22:02:46 +0200
Subject: [PATCH 3/4] ARM64: dts: meson-gx: add dmcbus and canvas nodes.
In-Reply-To: <CALecT5hgk+Wuh4-UWY29NNoEz-47Fx3pSjve8raCd3hRMzXE5w@mail.gmail.com>
References: <20180801185128.23440-1-maxi.jourdan@wanadoo.fr>
 <20180801185128.23440-4-maxi.jourdan@wanadoo.fr>
 <CALecT5hgk+Wuh4-UWY29NNoEz-47Fx3pSjve8raCd3hRMzXE5w@mail.gmail.com>
Message-ID: <CAHStOZ5VaOiOQhi7vG0Q9R7gF+LHvZim1qsEUJanZkFoXqgwDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> +                       sysctrl_DMC: system-controller at 0 {
>> +                               compatible = "amlogic,meson-gx-dmc-sysctrl", "syscon", "simple-mfd";
>
> we'd like to drop 'meson-' prefix, so better using "amlogic,gx-dmc-sysctrl",
> please take a look at the discussion here [1]
>
> [1] https://lkml.kernel.org/r/7hk1prmg4w.fsf at baylibre.com
>

On that subject, should I remove the meson keyword from dts only, or
from everything ?

e.g use amlogic_canvas_* symbols instead of meson_canvas_*, name the
source file "amlogic-canvas.c", etc. ?
