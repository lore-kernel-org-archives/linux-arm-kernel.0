From: lho@apm.com (Loc Ho)
Date: Wed, 6 May 2015 11:17:21 -0700
Subject: [PATCH v8 0/4] edac: Add APM X-Gene SoC memory controller EDAC
 driver
In-Reply-To: <20150506171242.GG22949@pd.tnic>
References: <1430884947-16787-1-git-send-email-lho@apm.com>
 <20150506084143.GA22949@pd.tnic>
 <CAPw-ZT=LepJr2Smjy81yhcTANdMRw99x1vR9rMoYsnHW_P3HPg@mail.gmail.com>
 <20150506171242.GG22949@pd.tnic>
Message-ID: <CAPw-ZTmC-KpOxEuZsL6BNsf44st_L356uY9y+ssYbxud8zeyZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>> It was discussed with Rob already in previous email. As we don't touch
>> the shared status registers besides reading status, it will just
>> register as shared interrupt.
>
> I don't see why that justifies the addition of an
> edac_xgene-<functional_unit> compilation unit and thus an .ko module per
> shared interrupt handler.

If you are concern about multiple module files, I can either combine
them as previous version or combine the multiple ko to an single ko
file.

-Loc
