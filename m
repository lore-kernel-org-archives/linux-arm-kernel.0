From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 2 Jan 2012 18:13:15 +0000
Subject: [RFC][PATCH 1/4] lcd: platform-lcd: Eliminate need for
 platform data
In-Reply-To: <CAJuYYwQrfp6R=kSzXr6y0unDk9FtNxoy3Lt5QabdNMg9Qux=bg@mail.gmail.com>
References: <1325483675-21908-1-git-send-email-thomas.abraham@linaro.org>
 <1325483675-21908-2-git-send-email-thomas.abraham@linaro.org>
 <20120102115959.GG2899@opensource.wolfsonmicro.com>
 <CAJuYYwQrfp6R=kSzXr6y0unDk9FtNxoy3Lt5QabdNMg9Qux=bg@mail.gmail.com>
Message-ID: <20120102181313.GA27875@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 02, 2012 at 11:21:46PM +0530, Thomas Abraham wrote:

> Your point on maintaining support for both old and new formats is
> helpful. But I am not sure if maintaining support for both formats is
> the right thing to do. As most of the ARM platforms will switch to
> using dt, maybe converting all of them to new format would be better.
> I will try doing this and prepare a patch.

There's more architectures than ARM supported in Linux and only a
minority of them are using device tree at the minute.  Unless every
architecture switches over platform data based users will still need to
be supported.
