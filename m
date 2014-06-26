From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 26 Jun 2014 00:11:37 -0300
Subject: [PATCH V2] ARM: imx: add cpufreq support for i.mx6sx
In-Reply-To: <CAOMZO5DOGgcZbD4zPhvaxerEHspSi4eQJhNsM=dxRVYCu6-e5w@mail.gmail.com>
References: <1403687412-22362-1-git-send-email-b20788@freescale.com>
 <CAOMZO5BDirj-5E0ha1iDzNSC1-+Exwo1QbZiP-7viDSpBqtEtQ@mail.gmail.com>
 <135a42da42024542b0f7a034ef1d63df@BY2PR03MB315.namprd03.prod.outlook.com>
 <CAOMZO5DOGgcZbD4zPhvaxerEHspSi4eQJhNsM=dxRVYCu6-e5w@mail.gmail.com>
Message-ID: <CAOMZO5AzgcavwQMW=41eWJVBiZ+5onJWUyQWKwS4NJcvGA5OVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 26, 2014 at 12:06 AM, Fabio Estevam <festevam@gmail.com> wrote:
> On Wed, Jun 25, 2014 at 11:53 PM, Anson.Huang at freescale.com
> <Anson.Huang@freescale.com> wrote:
>> Hi, Fabio
>>         I have already sent cpufreq driver patch for review which is supporting i.MX6SX, you may need to add it by yourself if you want to test it, I attached the patch, hope it helps.
>
> Thanks. It works fine now.

Forgot to mention that this error still appears:

cpu cpu0: dev_pm_opp_get_opp_count: device OPP not found (-19)
