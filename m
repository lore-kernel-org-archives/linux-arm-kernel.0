From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Apr 2014 18:09:53 +0200
Subject: [PATCH 2/4] pinctrl: msm: Make number of functions variable
In-Reply-To: <1396302597-31801-2-git-send-email-bjorn.andersson@sonymobile.com>
References: <1396302597-31801-2-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <CACRpkdaS7s44Szpu5eUVc-_DEDiGqer6FWc2VK-OUxTO4p-QKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 31, 2014 at 11:49 PM, Bjorn Andersson
<bjorn.andersson@sonymobile.com> wrote:

> The various pins may have different number of functions defined, so make this
> number definable per pin instead of just increasing it to the largest one for
> all of the platforms.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Patch applied for next (v3.16)

Yours,
Linus Walleij
