From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Wed, 17 Sep 2014 17:10:31 +0200
Subject: [PATCH v2 1/2] bcma: register bcma as device tree driver
In-Reply-To: <1410904582-6519-1-git-send-email-hauke@hauke-m.de>
References: <1410904582-6519-1-git-send-email-hauke@hauke-m.de>
Message-ID: <CACna6rzGa6wiKTrXbtUSGekRNq7gUkC0kyu4RQ_p4fG0Hd+DjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 September 2014 23:56, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> This driver is used by the bcm53xx ARM SoC code. Now it is possible to
> give the address of the chipcommon core in device tree and bcma will
> search for all the other cores.

Did you get any answer from Arend about detecting IRQs?

If not:
Arend: how much time it make take you to get an answer?
