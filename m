From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 31 Oct 2014 09:19:59 +0100
Subject: [PATCH RFC v2 3/8] pinctrl: pinconf-generic: Add parameter 'IO
 standard'
In-Reply-To: <62aa98fc84d14f919e35dd068d24e5a7@BN1BFFO11FD060.protection.gbl>
References: <1413479495-14206-1-git-send-email-soren.brinkmann@xilinx.com>
 <1413479495-14206-4-git-send-email-soren.brinkmann@xilinx.com>
 <CACRpkdZtqNUroNfd_0Kftq+-056YFzjvR+ROrZZ0htZX2v2qzg@mail.gmail.com>
 <62aa98fc84d14f919e35dd068d24e5a7@BN1BFFO11FD060.protection.gbl>
Message-ID: <CACRpkdYuFyRSZKp8u2dC4kCxojSrjYJ51_U+bkWnJuKeq7Hrvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 28, 2014 at 5:07 PM, S?ren Brinkmann
<soren.brinkmann@xilinx.com> wrote:

> So, this might also map to a certain drive-strength, but is not really
> mapping well to Zynq pin configuration options.
> Hence, I thought introducing this new property which allows a more
> flexible interpretation of the argument would be a better way and might
> also help other pinctrl cases (though this is speculative).

Maybe a new property is needed, but it doesn't seem generic enough.

It may be that you need to have a combination of generic and custom
config options (which is fine).

It may need some tweaking of the generic DT config parser to allow
custom attributes but that's needed one of these days anyway.

Yours,
Linus Walleij
