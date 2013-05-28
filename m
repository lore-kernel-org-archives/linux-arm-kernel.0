From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Tue, 28 May 2013 18:10:26 +0300
Subject: [RFC PATCHv4 0/6] arm: Initial TI-Nspire support
In-Reply-To: <3950519.8yj1SQodNQ@wuerfel>
References: <1369480087-24786-1-git-send-email-dt.tangr@gmail.com>
 <CACRpkdaQfaPQdJ1SDN--JDqcrXs8p6=FaDN+4KtKZF6nLtOvvw@mail.gmail.com>
 <1369750864.2939.1.camel@hornet> <3950519.8yj1SQodNQ@wuerfel>
Message-ID: <CAHp75Vern=-6KjfjsC+Y6N9H+yhb7eGC_Ui1Uf+8Y3069fqNow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 28, 2013 at 5:52 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>         depends on KMS_ARMCLCD != 'y'
>         depends on 'm' if KMS_ARMCLCD

Those two above could be one actually.

Just my 2 cents.

--
With Best Regards,
Andy Shevchenko
