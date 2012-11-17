From: axel.lin@ingics.com (Axel Lin)
Date: Sat, 17 Nov 2012 09:22:54 +0800
Subject: [PATCH RFT 1/2] pinctrl: dove: Fix dove_audio1_ctrl_set when
 BIT(0|1|2|3) of config is clear
In-Reply-To: <50A686A1.6000304@gmail.com>
References: <1352641495.3113.1.camel@phoenix> <50A0C3C8.2020501@gmail.com>
 <CAFRkauABcnqJSqewueY4rzVbm7uAqkZKitkR9ZmYjF0LhR26-Q@mail.gmail.com>
 <50A686A1.6000304@gmail.com>
Message-ID: <CAFRkauDg-HqYnBTatx-f6Rd3xZkD5CYE3Zc_-WdfwQX60F_HTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> pinctrl for Dove will not be enabled before DT clock support for Dove,
> which will hopefully make it into 3.8. If you agree, I will test and push it
> with the related patches for enabling pinctrl.
Ok. Thanks.

Axel
