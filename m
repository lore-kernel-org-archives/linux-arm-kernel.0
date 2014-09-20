From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Sat, 20 Sep 2014 15:20:35 +0200
Subject: [PATCH v3 1/2] bcma: register bcma as device tree driver
In-Reply-To: <1411218125-32670-1-git-send-email-hauke@hauke-m.de>
References: <1411218125-32670-1-git-send-email-hauke@hauke-m.de>
Message-ID: <CACna6rwozvugsSQDf_JQ=rj_PDNghvXc=JmvRAJeWp4gFdfuVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 September 2014 15:02, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> This driver is used by the bcm53xx ARM SoC code. Now it is possible to
> give the address of the chipcommon core in device tree and bcma will
> search for all the other cores.

Looks fine, thanks!
