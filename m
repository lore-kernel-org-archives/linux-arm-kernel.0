From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 4 Apr 2017 11:54:58 -0500
Subject: [PATCH v4 0/8] mfd: Add OF device table to I2C drivers that are
 missing it
In-Reply-To: <20170404153036.6651-1-javier@osg.samsung.com>
References: <20170404153036.6651-1-javier@osg.samsung.com>
Message-ID: <CAL_Jsq+FMrCOyjKXDBFR07AsD5nzSA2cRoBBix24NSBHiepo7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 4, 2017 at 10:30 AM, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:
> Hello,
>
> This series add OF device ID tables to mfd I2C drivers whose devices are
> either used in Device Tree source files or are listed in binding docs as
> a compatible string.

For the series,

Acked-by: Rob Herring <robh@kernel.org>
