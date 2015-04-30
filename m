From: bp@alien8.de (Borislav Petkov)
Date: Thu, 30 Apr 2015 23:30:46 +0200
Subject: [PATCH v7 3/5] Documentation: Add documentation for the APM
 X-Gene SoC EDAC DTS binding
In-Reply-To: <CAPw-ZTksYNDE2zVD=ZjGzpKfXQN8KgW85ZnHoQ2eVmSGdSdMOw@mail.gmail.com>
References: <1430259045-19012-1-git-send-email-lho@apm.com>
 <7128860.xHITr0VFap@wuerfel> <20150430094134.GD3488@pd.tnic>
 <10227049.9i19zDi2y3@wuerfel> <20150430130028.GF3488@pd.tnic>
 <CAPw-ZTnuyB2ne1C2-38qAxM_ANwdr9nuCYUMj=aTx7c90sVg+Q@mail.gmail.com>
 <20150430171846.GJ3488@pd.tnic>
 <CAPw-ZTksYNDE2zVD=ZjGzpKfXQN8KgW85ZnHoQ2eVmSGdSdMOw@mail.gmail.com>
Message-ID: <20150430213045.GK3488@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 30, 2015 at 02:19:44PM -0700, Loc Ho wrote:
> The top level interrupt may be different and APM specific unless other
> vendors adapt the same bit definitions. I highly doubt other vendor
> will use the same bit definitions. The CSW is APM only. The MCB A, MCB
> B, and memory controller are APM only. The L3, and SoC are APM specify
> only. For L1 and L2, I will need to check with the CPU designer - but
> likely APM specific.

So it sounds to me like this whole driver will control APM-specific hw
so a single driver should be fine.

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
