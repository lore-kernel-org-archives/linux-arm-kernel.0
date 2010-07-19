From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Mon, 19 Jul 2010 20:19:03 +0200
Subject: [PATCH 1/2] ARM: move SPEAr to use common mult/shift calculation
	code
In-Reply-To: <AANLkTinS5zMWdoxBczgpQmYWMgWI77Jwkyfz6LtMH8yK@mail.gmail.com>
References: <1275067996-17233-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTinS5zMWdoxBczgpQmYWMgWI77Jwkyfz6LtMH8yK@mail.gmail.com>
Message-ID: <AANLkTimSOKu_4K7b8H5rJIKUPfNi1ytpGF6ElTh9JeLu@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/19 shiraz hashim <shiraz.linux.kernel@gmail.com>:

> The timer on spear platforms is 16 bit only (say with min. functional
> freq as 187500 HZ.).
> With these values the resolution of the timer is not much so what
> should be the good value
> of SPEAR_MIN_RANGE.

I've set it to 4 seconds, it will scale properly to assure the system
will get as much resolution as possible while still being able to
sleep for 4 seconds. 187 kHz is quite slow anyway.

> Tested-by: Shiraz Hashim <shiraz.hashim@st.com>

Thanks!

Yours,
Linus Walleij
