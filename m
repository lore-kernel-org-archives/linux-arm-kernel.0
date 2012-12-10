From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 10 Dec 2012 23:03:09 +0900
Subject: [PATCH V4 0/2] Add DT support for i2s
In-Reply-To: <CAAgF-Bd3=W7+kd-uDASva_ofLySvVm1skpLij9WvSyhbfiP5-w@mail.gmail.com>
References: <1354099669-1735-1-git-send-email-padma.v@samsung.com>
 <CAAgF-Bc4t6WL4vswP6CFeSQrPZBmOuYfVt6_JoB1Za9TBX7mvA@mail.gmail.com>
 <20121206041141.GA10867@opensource.wolfsonmicro.com>
 <20121207135131.A53643E0B87@localhost>
 <CAAgF-BenOdFJK2LMot73_B=wHOFgD2sq8x-Ou=1CvpkiJpmeQQ@mail.gmail.com>
 <20121209072607.GD6511@opensource.wolfsonmicro.com>
 <CAAgF-Bd3=W7+kd-uDASva_ofLySvVm1skpLij9WvSyhbfiP5-w@mail.gmail.com>
Message-ID: <20121210140306.GA6103@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 10, 2012 at 04:30:50PM +0530, Padma Venkat wrote:

> Could you please explain me in more detail about "single DT link
> automatically expanded into two DAI links".
> How this can be done?

The device tree should only represent the single physical link that
exists and the handling of the DAIs should be done at runtime by some
piece of software.
