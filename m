From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 23 Aug 2011 17:08:38 +0800
Subject: [PATCH v2 2/4] ARM: CSR: add PM sleep entry for SiRFprimaII
In-Reply-To: <20110823085016.GH2796@pulham.picochip.com>
References: <1314080152-30503-1-git-send-email-Baohua.Song@csr.com>
	<1314080152-30503-3-git-send-email-Baohua.Song@csr.com>
	<20110823085016.GH2796@pulham.picochip.com>
Message-ID: <CAGsJ_4w8789ECkM68C4edtwQzy1+QCLjW+v0B+5UJi0=Z5TzyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> +
>> +static struct of_device_id pwrc_ids[] = {
>> + ? ? { .compatible = "sirf,prima2-pwrc" },
>
> Missing a sentinel terminator and const?

i have agreed with you about that before, but forget to fix that yet....
Thanks for pointing out again.

-barry
