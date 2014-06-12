From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Jun 2014 10:46:13 +0200
Subject: [PATCH 2/4] of: Add NVIDIA Tegra XUSB pad controller binding
In-Reply-To: <5390F5C7.5070301@wwwdotorg.org>
References: <1401894990-30092-1-git-send-email-thierry.reding@gmail.com>
 <1401894990-30092-2-git-send-email-thierry.reding@gmail.com>
 <53909F31.4050603@wwwdotorg.org> <20140605220833.GA28817@ulmo>
 <5390F5C7.5070301@wwwdotorg.org>
Message-ID: <CACRpkdZxS3UKaykTXsaGADCWmvfpAW_nhbxYHLSh44HMXLWvCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 6, 2014 at 12:57 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> In my opinion, the headers *are*
> part of the bindings, so of course anyone either reading DT bindings, or
> parsing DT, must have the headers, and hence the headers must be bundled
> with the DT files or with the bindings wherever they go.

I agree 100% with Stephen's stance. Reference the headers.

Yours,
Linus Walleij
