From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Thu, 4 Oct 2018 09:11:47 -0700
Subject: [PATCH i2c-next v5 4/5] i2c: aspeed: Remove hard-coded bus
 timeout value setting
In-Reply-To: <CACPK8XdTMfdw1Tu97oD7R7MXQKGHnA5A+SVfAA3RDkiTd_bawA@mail.gmail.com>
References: <20181003223107.16133-1-jae.hyun.yoo@linux.intel.com>
 <20181003223107.16133-5-jae.hyun.yoo@linux.intel.com>
 <CACPK8XdTMfdw1Tu97oD7R7MXQKGHnA5A+SVfAA3RDkiTd_bawA@mail.gmail.com>
Message-ID: <185b73f1-ad5f-eedb-7c56-2a2e266f5960@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/4/2018 1:32 AM, Joel Stanley wrote:
> On Thu, 4 Oct 2018 at 00:31, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>>
>> This commit removes hard-coded bus timeout value setting so that
>> it can be set by i2c-core-base.
>>
>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 

Thanks for the review, Joel!
