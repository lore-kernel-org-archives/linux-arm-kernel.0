From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 3 Jul 2016 15:23:37 -0300
Subject: [PATCH v2] clk: imx7d: do not set parent of ethernet time/ref
 clocks
In-Reply-To: <20160703174813.13970-1-stefan@agner.ch>
References: <20160703174813.13970-1-stefan@agner.ch>
Message-ID: <CAOMZO5AghMZ0iV0=0hBrFhhhAAfPpyxH0oj8UT7TqZr9N0+y9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Sun, Jul 3, 2016 at 2:48 PM, Stefan Agner <stefan@agner.ch> wrote:

> Fabio, thanks for testing v1.
>
> With v2, the warnings should definitly be gone. However, that might
> break some boards...

Still see the warnings with v2.
