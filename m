From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 3 Apr 2018 16:47:31 +0200
Subject: stable-rc build: 4 warnings 0 failures (stable-rc/v4.15.15)
In-Reply-To: <5abfca32.5d57620a.a2eca.898b@mx.google.com>
References: <5abfca32.5d57620a.a2eca.898b@mx.google.com>
Message-ID: <CAK8P3a1-VqB8mbixuHdsZbfCbGBpVppO4KX4VuZ5AJCHbYooAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 31, 2018 at 7:49 PM, Olof's autobuilder <build@lixom.net> wrote:

> Warnings:
>
>         arm64.allmodconfig:
> WARNING: modpost: missing MODULE_LICENSE() in drivers/phy/qualcomm/phy-qcom-ufs.o

This needs a backport of

59fba0869aca ("phy: qcom-ufs: add MODULE_LICENSE tag")

       Arnd
