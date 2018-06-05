From: sebastien.szymanski@armadeus.com (=?UTF-8?Q?S=c3=a9bastien_Szymanski?=)
Date: Tue, 5 Jun 2018 09:07:00 +0200
Subject: [PATCH v3 1/3] cpufreq: imx6q: check speed grades for i.MX6ULL
In-Reply-To: <20180523042953.kcp2h5xtwjrjponn@vireshk-i7>
References: <20180522062853.24799-1-sebastien.szymanski@armadeus.com>
 <20180523042953.kcp2h5xtwjrjponn@vireshk-i7>
Message-ID: <717f24e1-3846-7685-b440-0754da883c2a@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/23/2018 06:29 AM, Viresh Kumar wrote:
> On 22-05-18, 08:28, S?bastien Szymanski wrote:
>> Check the max speed supported from the fuses for i.MX6ULL and update the
>> operating points table accordingly.
>>
>> Signed-off-by: S?bastien Szymanski <sebastien.szymanski@armadeus.com>
>> ---
>>
>> Changes for v3:
>>  - none
> 
> @Sascha and Shawn: Can you guys please Ack this series if there is
> nothing wrong with it ?
> 

ping...

-- 
S?bastien Szymanski
Software engineer, Armadeus Systems
Tel: +33 (0)9 72 29 41 44
Fax: +33 (0)9 72 28 79 26
