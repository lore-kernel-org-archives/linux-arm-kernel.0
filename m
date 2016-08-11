From: sunil.kovvuri@gmail.com (Sunil Kovvuri)
Date: Thu, 11 Aug 2016 15:27:09 +0530
Subject: [PATCH 04/21] net: thunderx: Set queue count based on number of
 CPUs
In-Reply-To: <CO2PR11MB008837F849AB5891E076DF41971E0@CO2PR11MB0088.namprd11.prod.outlook.com>
References: <1470811373-28277-1-git-send-email-sunil.kovvuri@gmail.com>
 <1470811373-28277-5-git-send-email-sunil.kovvuri@gmail.com>
 <CO2PR11MB008837F849AB5891E076DF41971E0@CO2PR11MB0088.namprd11.prod.outlook.com>
Message-ID: <CA+sq2CduEUujN_6BA9fOrFaW9XjzS-R01ZG7q2de3aUYDw2uwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> We have netif_get_num_default_rss_queues() which does this.
Thanks for pointing out the generic API.
Will make changes and resubmit.
