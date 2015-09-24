From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 24 Sep 2015 21:27:49 +0900
Subject: [PATCH v2 0/2] pinctrl: uniphier: one fix, one addition
In-Reply-To: <1441964010-6885-1-git-send-email-yamada.masahiro@socionext.com>
References: <1441964010-6885-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNARMWa+p6OazVRVQkqZaUqnZXUObLOTL+nS1C=QR=Q_ceQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-09-11 18:33 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>
> 1/2 is a bug fix, but it is not very critical.
> I can wait until 4.4-rc1 if it is a hassle.
>
> 2/2 provides some more pin-mux settings.
>
>
> Changes in v2:
>   - trivial.  Fix a typo in git-log.  s/value/values/
>
> Masahiro Yamada (2):
>   pinctrl: uniphier: fix input enable settings for PH1-sLD8
>   pinctrl: uniphier: add SD card pinmux settings
>
>  drivers/pinctrl/uniphier/pinctrl-ph1-ld4.c     |   5 +
>  drivers/pinctrl/uniphier/pinctrl-ph1-ld6b.c    |   5 +
>  drivers/pinctrl/uniphier/pinctrl-ph1-pro4.c    |  11 ++
>  drivers/pinctrl/uniphier/pinctrl-ph1-pro5.c    |   5 +
>  drivers/pinctrl/uniphier/pinctrl-ph1-sld8.c    | 230 +++++++++++++------------
>  drivers/pinctrl/uniphier/pinctrl-proxstream2.c |   5 +
>  6 files changed, 148 insertions(+), 113 deletions(-)
>


This series has been superseded by v3.


-- 
Best Regards
Masahiro Yamada
