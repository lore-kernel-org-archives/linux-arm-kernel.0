From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 24 Dec 2013 00:55:09 -0200
Subject: [PATCH 1/2] ARM: dts: imx6qdl-sabresd: Add PFUZE100 support
In-Reply-To: <20131224025547.GC27081@Robin-OptiPlex-780>
References: <1387826937-9734-1-git-send-email-festevam@gmail.com>
 <20131224025547.GC27081@Robin-OptiPlex-780>
Message-ID: <CAOMZO5C-0g+LrwqnmJA_Uwyw43UAZSGnmY7JPcLy3nySTZ+GGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 24, 2013 at 12:55 AM, Robin Gong <b38343@freescale.com> wrote:

>> +                     sw2_reg: sw2 {
>> +                             regulator-min-microvolt = <800000>;
>> +                             regulator-max-microvolt = <3950000>;
> Should be 3300000, right?

Actually it should be:

                     sw2_reg: sw2 {
                             regulator-min-microvolt = <400000>;
                             regulator-max-microvolt = <3300000>;

Do you agree?

Regards,

Fabio Estevam
