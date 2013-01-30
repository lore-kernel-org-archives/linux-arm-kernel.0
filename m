From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 30 Jan 2013 10:27:39 -0700
Subject: [PATCH 1/1] pinctrl: nomadik: Rename Device Tree compatible string
In-Reply-To: <20130130170750.GA5217@gmail.com>
References: <1359563102-5934-1-git-send-email-linus.walleij@stericsson.com>
 <51094E50.4000302@wwwdotorg.org> <20130130170750.GA5217@gmail.com>
Message-ID: <5109580B.2050309@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/30/2013 10:07 AM, Lee Jones wrote:
> The preference is to use '-' instead of '_' in compatible strings.

OK, this version seems complete. One issue here is that older device
trees now won't work with newer kernels since the driver's support of
the original compatible value is removed. DT is supposed to be backwards
compatible, but perhaps at this earlyish stage you don't care about this
on your platform yet?
