From: thommyj@gmail.com (Thommy Jakobsson)
Date: Fri, 3 Jun 2016 20:32:05 +0200
Subject: [PATCH 2/2] arm-smmu: Add possibillity to mask streamIDs
In-Reply-To: <HE1PR0401MB18663F72E21C5E237E0F2D2FE6590@HE1PR0401MB1866.eurprd04.prod.outlook.com>
References: <1464640806-3942-1-git-send-email-thommyj@gmail.com>
 <1464640806-3942-3-git-send-email-thommyj@gmail.com>
 <DB5PR0401MB186309ACEF30FEA489C3CA97E6580@DB5PR0401MB1863.eurprd04.prod.outlook.com>
 <CAOTQ16KS6RobKfs5MP=Bx2ad6Xipht7VO4CP5DbzQr9T60ip=A@mail.gmail.com>
 <HE1PR0401MB18663F72E21C5E237E0F2D2FE6590@HE1PR0401MB1866.eurprd04.prod.outlook.com>
Message-ID: <CAOTQ16LTW6s9Y9uLZs4S5+z=+-Cc5k6BH8pmxF5+t32tcSkU0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>[Gupta Nipun] I am not an expert in this, but I do not see any reason for 'of_for_each_phandle' to not work
Did a fetch and tried again, now it works on target. Not sure if the
fetch did magic or if I just did wrong last time.
New patch uploaded with of_for_each_phandle instead

BR,
Thommy Jakobsson
