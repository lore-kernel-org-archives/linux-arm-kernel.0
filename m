From: shubhrajyoti.datta@gmail.com (Shubhrajyoti Datta)
Date: Fri, 7 Aug 2015 09:25:48 +0530
Subject: [PATCH v3] iio: adc: xilinx-xadc: Push interrupts into threaded
 context
In-Reply-To: <55C0722C.7080904@metafoo.de>
References: <CAKfKVtGTO81wLWk50M303t2WjcBEMEt_LUnsJ3_WmvR_3izUjg@mail.gmail.com>
 <1437434050-32907-1-git-send-email-xander.huff@ni.com>
 <55B231DE.4080308@metafoo.de>
 <CAKfKVtGegy2P_YWQAtKEzByN-+q+bq=uus4zNvO4sghXRjpGPQ@mail.gmail.com>
 <55C0722C.7080904@metafoo.de>
Message-ID: <CAKfKVtHPYqB1zjRad2=_xe9LEAuWs8PipNHHC5eUfW=XwChT2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 4, 2015 at 1:35 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>
> Well there is no need to use a threaded IRQ. The interrupt handler is quite
> small and doesn't take too much time and doesn't have any delays or sleeps
> in it either.
>
>
Ok thanks for the explanation.
