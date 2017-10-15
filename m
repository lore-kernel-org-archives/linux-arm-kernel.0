From: timur@codeaurora.org (Timur Tabi)
Date: Sun, 15 Oct 2017 16:09:19 -0500
Subject: [PATCH 0/2] [v5] pinctrl: qcom: add support for sparse GPIOs
In-Reply-To: <20171015201811.GA13063@mithrandir>
References: <CACRpkdZcdLac_wYW+XqtZ=-APo8VmvYL4B1oL-wZyLy8KEs9AA@mail.gmail.com>
 <1ecdf6ee-5098-15d3-f85e-66b39a6c25f9@codeaurora.org>
 <CACRpkdaUV1Mjh7U9bBAgZA5Zq1oqN0HBT=VH5NkvPnY4gHxDVw@mail.gmail.com>
 <d53e67a2-4f69-752f-ba35-53872d9b9760@codeaurora.org>
 <CACRpkdYfAcKrgbgybccurUKTyR0E+tHDyzp7sbXxXxKuyMOGhQ@mail.gmail.com>
 <619f48d2-59c7-c090-4ace-9e8db9f92064@codeaurora.org>
 <CACRpkdZFunwQ=tiQqsapap7Ozz42hr=df5vqbC0S5xy5Wn+ZWw@mail.gmail.com>
 <255ad0dc-2d16-ae7f-0b45-500e23cff1a4@codeaurora.org>
 <20171003220311.GU457@codeaurora.org>
 <4f067c09-9ecf-9266-baa0-18575bca94eb@codeaurora.org>
 <20171015201811.GA13063@mithrandir>
Message-ID: <a6296a97-d9fc-2135-33a7-3eba436f0433@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15/17 3:18 PM, Thierry Reding wrote:
> This confuses me. Why would you even want to register pins that don't
> exist? It sounds to me like you're lying to gpiolib and then try to work
> around it trying to access the GPIOs that don't exist but which you told
> it were there.
> 
> Why not just tell gpiolib about only the GPIOs that exist?

Please look at my patches.  That's exactly what they do, but no one else 
likes that approach.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
