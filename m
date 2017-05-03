From: roszenrami@gmail.com (Rami Rosen)
Date: Wed, 3 May 2017 23:39:04 +0300
Subject: [PATCH 0/9] net: thunderx: Adds XDP support
In-Reply-To: <CA+sq2CfW89EbiZmp6byc3y3cbATmmyVB=avzrUXG51-x3yxckg@mail.gmail.com>
References: <1493730418-24606-1-git-send-email-sunil.kovvuri@gmail.com>
 <20170502.154744.1762061314370744901.davem@davemloft.net>
 <CA+sq2CfW89EbiZmp6byc3y3cbATmmyVB=avzrUXG51-x3yxckg@mail.gmail.com>
Message-ID: <CAKoUArku6tRuV=Y3fteY-R6eHM4daq-0ct6w1_unjkGA+yPTFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks, Sunil.

>with network stack: 0.32 Mpps
>with XDP (XDP_TX): 3 Mpps
>and XDP_DROP: 3.8 Mpps

Interesting; May I ask - which packet size did you use ?

Regards,
Rami Rosen
