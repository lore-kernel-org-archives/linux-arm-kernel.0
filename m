From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 17 Feb 2016 20:29:11 -0200
Subject: [PATCH v2 2/3] ARM: dts: vf-colibri: add basic supply regulators
In-Reply-To: <a07b405a5c73b092eaa6422b8562b56f@agner.ch>
References: <1455668317-15728-1-git-send-email-stefan@agner.ch>
 <1455668317-15728-2-git-send-email-stefan@agner.ch>
 <CAOMZO5Bb1eGSinoNkUhB_2w8mWdA+RQA0Z4geJp8B-MfGryAHw@mail.gmail.com>
 <a07b405a5c73b092eaa6422b8562b56f@agner.ch>
Message-ID: <CAOMZO5CSw=Gx52H27C_H2ytnkup6emgVxv5=FPmGnmTMEjE9CA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2016 at 7:52 PM, Stefan Agner <stefan@agner.ch> wrote:

> Hm, should I remove them also in Patch 1/3? It's a fixed regulator too,
> hence I guess regulator-always-on is pointless there too...?

That's correct. And from 3/3 too.
