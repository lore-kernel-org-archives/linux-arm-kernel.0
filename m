From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 5 Oct 2015 11:22:03 +0200
Subject: [PATCH v2] twd: Don't set CLOCK_EVT_FEAT_C3STOP unconditionally
In-Reply-To: <56124035.6080107@sigmadesigns.com>
References: <56123BD0.8010005@sigmadesigns.com>
 <56124035.6080107@sigmadesigns.com>
Message-ID: <CACRpkdbWRU3UH6aJnqdcuzdh_-sE7ryhs0vBTUbbRDcJ7PWXLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 5, 2015 at 11:17 AM, Marc Gonzalez
<marc_gonzalez@sigmadesigns.com> wrote:

> +Optional
> +- twd_never_stops : Don't set the CLOCK_EVT_FEAT_C3STOP flag.

We don't use _underscores_ much in bindings.

twd-never-stops; is more common.

Write that this is a bool flag.

Yours,
Linus Walleij
