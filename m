From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Feb 2014 11:07:20 +0100
Subject: [PATCH v4 04/16] pinctrl: mvebu: remove passing mvebu_mpp_ctrl to
 callbacks
In-Reply-To: <1393165274-32492-5-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1392220776-30851-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1393165274-32492-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1393165274-32492-5-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <CACRpkdaow9=szPT2tT+am1amyBLU1bK+YZ6CSmLJQpR6x2WHGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 23, 2014 at 3:21 PM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:

> The only valuable information a special callback can derive from
> mvebu_mpp_ctrl passed to it, is the pin id. Instead of passing
> the struct, pass the pid directly.
>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Tested-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
