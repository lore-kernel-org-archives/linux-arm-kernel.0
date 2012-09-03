From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 3 Sep 2012 11:32:12 +0200
Subject: [PATCH v2 1/9] pinctrl: mvebu: pinctrl driver core
In-Reply-To: <50431871.1030507@gmail.com>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1345623750-10645-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1345623750-10645-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <5035445B.6000500@wwwdotorg.org>
 <CABJ1b_Tdr80DGqb-FRzwDbF3m7g6fBguk5GtRAfRUYx5Sqy_cA@mail.gmail.com>
 <50366E44.4030606@wwwdotorg.org> <50369305.6050304@gmail.com>
 <50369FEE.8000003@wwwdotorg.org> <5036B639.20608@gmail.com>
 <5036F651.4020700@wwwdotorg.org> <5038F50E.7030807@gmail.com>
 <503AF8B4.1070206@wwwdotorg.org>
 <CACRpkdYsPadKr1i8m5cCAFUUvJYUnLmc3j8evKM_6rPU5oGzRg@mail.gmail.com>
 <50431871.1030507@gmail.com>
Message-ID: <CACRpkdaHm9YZjM7GzZ-VEPgQfn86XrjdO1ZYWMuohCQH1PshZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 2, 2012 at 10:27 AM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:

> there is a v3 of the patch under internal review right now.

OK I'll review as you send it out. Will look through the v2 patches to
see if I missed some comment.

> I know Stephen will not like it, but I decided not to have the list of
> functions passed statically from the SoC specific part but generate it
> out of pingroups during probe().

Well, Tony's driver does even nastier things so we need to agree
to disagree on this point. I for one can live with it.

Yours,
Linus Walleij
