From: vigneshr@ti.com (Vignesh R)
Date: Thu, 23 Mar 2017 17:52:46 +0530
Subject: [PATCH 0/2] serial: Add name field to uart_port
In-Reply-To: <CAHp75VdhHj-7Utganxo1YnSABmnM5KC+bVJe2KgXx65hNHNGng@mail.gmail.com>
References: <20170321133636.8814-1-vigneshr@ti.com>
 <CAHp75VdhHj-7Utganxo1YnSABmnM5KC+bVJe2KgXx65hNHNGng@mail.gmail.com>
Message-ID: <21173bda-55e5-b9d0-5eb1-335091fbca6a@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 23 March 2017 12:16 AM, Andy Shevchenko wrote:
> On Tue, Mar 21, 2017 at 3:36 PM, Vignesh R <vigneshr@ti.com> wrote:
>> This series adds name attribute to uart_port struct inorder to store
>> name of the tty port that will help in identify different uart
>> instances.
>> This patch series is based on discussion here[1].
> 
> Please, use versioning for the series. This AFAIU should be v3, and
> next (which is expecting based on comments) would be v4.

The very first patch I submitted was accepted. So I did not make the
previous patch as v2 as it was an incremental fix. Since, this series is
very different from previous patch, I chose not to label this as v3.
Anyways, will make the next version as v4.

Thanks for the review!


-- 
Regards
Vignesh
