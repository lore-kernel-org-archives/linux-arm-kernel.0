From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Wed, 17 Jul 2013 10:14:56 +0200
Subject: [PATCH v8] ARM: clocksource: add support for MOXA ART SoCs
In-Reply-To: <51E56043.1010509@linaro.org>
References: <1373024773-24574-1-git-send-email-jonas.jensen@gmail.com>
 <1373985880-23469-1-git-send-email-jonas.jensen@gmail.com>
 <51E56043.1010509@linaro.org>
Message-ID: <CACmBeS129VOmFjnF+-iRH1viS+zpoaNMYMaWZ_UiPVxa6ncYeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 July 2013 17:01, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> 1. could you elaborate the patch log: as it is a new driver, a nice
> description of the timer hardware would be valuable for people willing
> to understand the code (eg. some specificities of the driver).

A short description is now added to the commit message, I hope this is
what you wanted, I can reformat the text if needed.

> 2. fix the alignment below

I don't see the alignment error, I think this is because git adds the
one '+' character, it should be correct once applied?


Best regards,
Jonas
